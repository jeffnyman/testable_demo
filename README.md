# Testable Demo

> **"We have such sights to show you."**
> > Pinhead, _'Hellraiser'_

This repository exists solely to provide a series of contrived, but realistic, examples using a minimal-footprint, low-friction, high-yield test-supporting micro-framework. This micro-framework showcases various patterns that are considered effective for automation.

The goal is to show what automation that provides a "lucid viewpoint" (or "lucid testing") looks like.

The framework in question will be my own [Testable](https://github.com/jeffnyman/testable).

## Execution

Current execution can be done via the `lucid` script. This is currently just a wrapper for Cucumber.

```
./lucid
```

This will run all of the feature specifications. By default, Chrome will be used as the browser to execute against. You can run against other browsers (assuming you have the browsers and the drivers on your machine).

```
./lucid BROWSER=firefox
./lucid BROWSER=ie
./lucid BROWSER=edge
```

## WebDriver Binaries

This project uses [WebDrivers](https://github.com/titusfortner/webdrivers), which will automatically download certain WebDriver binaries for you. Currently the best supported binaries are Chrome and Firefox and that's because these are the most reliable to get. There is support to attempt grabbing the IE driver server as well as the MSWebDriver. The latter is used for Edge while the former is used for Internet Explorer.

You do not have to use this WebDriver manager. If you have the drivers available on a system or user path, they will be used.

## Why Cucumber?

There are a lot of polarized opinions on the use of tools, like Cucumber. I wrote about some of this:

* [Why Cucumber? Why Gherkin?](http://testerstories.com/2014/10/why-cucumber-why-gherkin/)
* [Is Cucumber Truly Misunderstood?](http://testerstories.com/2014/10/is-cucumber-truly-misunderstood/)

One of the benefits of this kind of tooling that supports test design as well as test execution is that you can work on building a "test description language" (a TDL). Another way to frame that is as a "business description language" (a BDL). This is what allows teams to implement approaches like Behavior-Driven Development (BDD). I wrote a lot about the concept of a TDL:

* [TDL Posts](http://testerstories.com/category/tdl/)

Again, one of the key points for me is the idea that you can link testing as design activity and testing as execution activity. Cucumber is by no means the only way to do this. But it can be a very effective way assuming your testing puts more emphasis on collaboration, communication and expression than it does on simply executing tests.

## General Structure

One thing I like to try and do is keep things as high-level as possible, in terms of directory structure. That way it's clear what goes where and people don't have to navigate down nested paths to find information. Further, this does allow selective display -- or at least selective referencing -- of some information. For example, it's possible to just reference a `config` directory or a `features` directory.

## Configuration

There is a core configuration module in `config/config.rb`. This utilizes specific data files. The `config/config.yml` file contains the default information for whatever is relevant for a given test environment. In the case of this demonstration, a group, a particular server, and a particular user. The details for this information (_which_ group, _which_ server, _which_ user) are located in the `environments.yml` file. The core configuration module contains methods that will read this information on-demand so that it can be used in tests.

There is a `test-configs.rb` file that demonstrates usage.

How this basically works is the _group_ value is read from `config.yml`. Then the `environments.yml` file is searched for a key with the name of that group. Each group will have one or more servers associated with it. The _server_ value from `config.yml` is then matched up, in `environments.yml`, with a server key of that same name within that group. Finally, each group and each server are associated with a user. So the _user_value from `config.yml` is matched up with the relevant user information in `environments.yml`. All of this is what allows a user, with username and password, to login to a specific server.

The easiest place to see all this in use is in `models\home.rb`, where you can see the URL and the user information is referenced.

A key thing to note is that my own [Data Accessible](https://github.com/jeffnyman/data_accessible) extension. What this extension does is make the data act as if it was a "first class citizen" and, in this context, that means the data names can be called as if they were methods. So this bit of text exists in `config.yml`:

```yaml
config:
  current:
    group: demo
```

What Data Accessible does is allow you to put a statement like this in your code:

```ruby
config.current.group
```

That would return a value of "demo". So you can see that each of the keys in the data file are treated as if they were methods that were nested together.

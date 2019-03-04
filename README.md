# SM

SM is a Java-like DSL for modeling simple state machines. It supports a subset
of the standard object-oriented approach, namely namespaces (here: packages),
classes (here: machines), fields and methods.

In addition, you can also natively define states an instance can be in, events a
machine can receive and transitions which should be performed when an event is
processed. To make this work, the action language provides a statement for
raising an event in an instance and an expression for checking the current state
of a machine.

SM is made with Xtext & Xtend, and is based on Xbase, the reusable expression
language of Xtext. As a result, integration with Java and the Eclipse IDE can be
realized with little effort. This project serves as a teaching material for a
master's course on compilers at Eötvös Loránd University, Budapest, Hungary.

## Installation

1. Before starting, make sure you have a JDK 8 implementation installed on your
computer. As this is not the latest version, on some GNU/Linux distributions you
might need to use external package repositories to obtain it.

1. SM is written for Eclipse, in Eclipse, therefore the next step is to acquire
the host IDE. We recommend the *[Eclipse IDE for Java and DSL Developers](https://www.eclipse.org/downloads/packages/release/2018-12/r/eclipse-ide-java-and-dsl-developers)*
package of Eclipse 2018-12. Slightly different versions might also work, but a
matching Xtext SDK is mandatory.

1. In Eclipse, import projects *hu.elte.sm*, *hu.elte.sm.ide* and *hu.elte.sm.ui*
through *File > Import... > General > Existing Projects into Workspace*. Then
launch the *Generate SM (sm) Language Infrastructure* configuration from *Run >
Run Configurations... > Mwe2 Launch* and let the framework download ANTLR when
asked about it.

1. Once the language infrastructure is generated, after a healthy dose of cleans
& rebuilds you should get no compiler errors. To actually try SM, fire up a
runtime Eclipse instance through *Run > Run Configurations... > Eclipse
Application > Launch Runtime Eclipse* and proceed to the next section of this
guide.

## Usage

The most convenient way of getting to know SM leads through the examples
provided in project *hu.elte.sm.examples*. Import this into the previously
started *runtime* Eclipse instance by selecting it in *File > Import... >
General > Existing Projects into Workspace*.

- The *Count* example in package *hu.elte.sm.examples.count* contains a simple
machine which can register *and* count ticks, where the latter depends on its
current state. Notice how it is used as a conventional Java class inside
*Count.java*, even with regards to generated members like the `handleEvent`
method and the `Event` enum.

- *Hospital* presents a little more complicated example with three interacting
machines simulating a doctor and two patients, randomly befriending and
cross-infecting each other in the hope of eventual recovery. Several forms of
both internal & external communication and state checks can be seen in action
here, as well as the usage of Java-types inside SM.

You can also define your own SM projects by creating a standard Java project
in *File > New > Other... > Java > Java Project* and then adding a plain file
through *File > New > Other... > General > File* to it with extension *sm*
(for example, *Counter.sm*). At this point, Eclipse will ask you whether you
want to convert this project into an Xtext one, which offer you should
gracefully accept. We also recommend attaching the *Xtend Library* to your SM
projects by selecting *Build Path > Add Libraries...* from the project's context
menu.

Finally, we advise trying out how the language infrastructure behaves under
common Eclipse functions. Check the syntax highlighting, jump through references,
look at the outline, produce validation errors, try your luck with quickfixes,
ask the content assist, place breakpoints and start cross-language debugging.

## License

This software is licensed under the MIT license. See file
*[LICENSE](https://github.com/djnemeth/sm/blob/master/LICENSE)* for details.

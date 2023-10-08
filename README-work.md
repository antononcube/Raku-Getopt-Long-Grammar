# Getopt::Long::Grammar

Raku package for parsing Getopt specs and Python CLI specs.

### Motivation

Given a 
[Jupyter chatbook made with Python kernel](https://pypi.org/project/JupyterChatbook/) 
I want to be able to switch to a 
[Raku kernel](https://raku.land/zef:antononcube/Jupyter::Chatbook) 
for that chatbook and use the chat cells as they are, without changing the "magic specs." 
This means, being able to parse the magic argument specs the way Jupyter Python uses them.
(See 
["IPython extensions"](https://ipython.readthedocs.io/en/stable/config/extensions/index.html) and
["argparse"](https://docs.python.org/3/library/argparse.html).) 

-----

## Installation

From [Zef ecosystem]():

```
zef install Getopt::Long::Grammar
```

From GitHub:

```
zef isntall https://github.com/antononcube/Raku-Getopt-Long-Grammar.git
```

-----

## Usage examples

Load the package and parse a typical magic command:

```perl6
use Getopt::Long::Grammar;

my $cmd = '%%chat_meta cw1 --api_key=cd77fdfw1 --prompt';

getopt-parse($cmd);
```

Interpret:

```perl6
getopt-interpret($cmd);
```




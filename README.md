Description

kmip is a KMIP (http://www.oasis-open.org/committees/kmip/) ragel/C based protocol parser.

Requirements

 * ragel
 * python for tests

Build

To build kmip:

make

Example

The test directory contains python scripts to generate binary data files which can be used to test the parser.

Run 'python test/response1.py' to produce test1.bin then run './kmip test1.bin'.

Current state

The current version contains rules for parsing requests and responses. Note that the actions do little other than print
information about the tag and associated data.

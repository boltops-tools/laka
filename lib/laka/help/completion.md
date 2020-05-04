## Examples

    laka completion

Prints words for TAB auto-completion.

    laka completion
    laka completion hello
    laka completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(laka completion_script)

Auto-completion example usage:

    laka [TAB]
    laka hello [TAB]
    laka hello name [TAB]
    laka hello name --[TAB]

---
Git Workflow for Mixing Public and Private Repository
---

![Local and remote public and private repositories and their
interactions](./figures/dir-setup.png)

The figure above illustrates the workflow that lets you collaborate on
public code while keeping some of your own developments private. The
main concept is simple; it involves making the public repository a
submodule of the private repository. The important feature of this
workflow is that it keeps the histories of the repositories linked. On
the figure, the public repository (in red) is added to the private
repository (in blue) as a submodule. Locally, the public code is a
directory of the private code. Changes can be made to the public code
within the public directory and pushed directly to the public remote
repositories. Similarly, changes to the remote public repository can be
pulled diretly into the submodule directory in the local clone of the
private repository.

The bash script [git-pub-private.sh](./git-pub-private.sh) demonstrates
how to build this workflow on the simple example shown on the figure.
Specifically, it shows:

1.  how to build local and remote public and private repositories.
2.  make the public repository a submodule of the private repository.
3.  update the submodule from changes in the remote public repository.
4.  update the remote public repository from changes made in the remote
    public repository.

References
==========

-   [Pro Git - Git -
    Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules#:~:text=Submodules%2520allow%2520you%2520to%2520keep,and%2520keep%2520your%2520commits%2520separate.)
-   [Git submodule \|
    Atlassian](https://www.atlassian.com/git/tutorials/git-submodule)

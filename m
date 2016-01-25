From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2016 12:16:54 +0100
Subject: [LTP] test.sh and ROD redirection
In-Reply-To: <56A1F33A.4000807@oracle.com>
References: <20160121135150.GA18731@rei.lan>
 <56A1F33A.4000807@oracle.com>
Message-ID: <20160125111654.GA30655@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > As I've been doing last minute fixes to shell testcases I've stambled
> > upon this problem. We have a couple of places that do:
> >
> > ROD echo foo > bar
> >
> > And while this works fine if the command executes successfully it writes
> > the error message to the file bar on failure as well (since the part
> > that gets to the ROD as $@ is the 'echo foo' while the '> bar' is parsed
> > by the shell.
> >
> > One solution would be redirecting the messages from tst_* to stderr, so
> > we would be able to at least see the error message, but this wouldn't
> > catch errors when we cannot write to the 'bar' (since echo foo would
> > executed successfully anyway).
> This won't work in case of simple file creation: ROD >file. Quotation 
> marks seem to help in this case with ROD.
> 
> ./testcases/network/nfs/nfs_stress/nfs03:            ROD >file$j$k
> 
> can be changed to ROD ">file$j$k"

You lost me here. All I wanted to do is:

--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -47,7 +47,7 @@ tst_resm()
 
        local ret=$1
        shift
-       echo "$TCID $TST_COUNT $ret : $@"
+       echo "$TCID $TST_COUNT $ret : $@" >&2

This should not break anything. And maybe this is a good idea regardless the
original problem.

> > Another solution would be to create ROD_ECHO and ROD_CAT and change ROD
> > to abort if anybody tries to use it with these two. Which solves our
> > usage pattern but this is clumsy and still broken as anyone can redirect
> > output from ROD anyway.
> 
> Could be just one ROD_RED that accepts parameters in this way: 1st for 
> exec and
> the others to set after '>' redirection.
> 
> ROD_RED()
> {
>      $1 > ${@:2}
>      if [ $? -ne 0 ]; then
>      ....
> }
> 
> ROD_RED "echo 0" "file"

This sounds good, but I would like to have the file as single argument
so that we do not have to quote the command in question. The easiest
solution would be to have the file to be the first argument, but that is
counter intuitive, so I would rather go with the last even if the code
ends up far more complicated.

Another option would be inventing our special syntax for redirecting for
ROD. Use for example % and threat it like > i.e. split $@ on % and
redirect the output to whatever is found after % which shouldn't be
much more complicated than separating last parameter from $@...

-- 
Cyril Hrubis
chrubis@suse.cz

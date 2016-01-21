From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jan 2016 14:51:50 +0100
Subject: [LTP] test.sh and ROD redirection
Message-ID: <20160121135150.GA18731@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
As I've been doing last minute fixes to shell testcases I've stambled
upon this problem. We have a couple of places that do:

ROD echo foo > bar

And while this works fine if the command executes successfully it writes
the error message to the file bar on failure as well (since the part
that gets to the ROD as $@ is the 'echo foo' while the '> bar' is parsed
by the shell.

One solution would be redirecting the messages from tst_* to stderr, so
we would be able to at least see the error message, but this wouldn't
catch errors when we cannot write to the 'bar' (since echo foo would
executed successfully anyway).

Another solution would be to create ROD_ECHO and ROD_CAT and change ROD
to abort if anybody tries to use it with these two. Which solves our
usage pattern but this is clumsy and still broken as anyone can redirect
output from ROD anyway.

Is there a elegant solution to this problem that I'm missing?

-- 
Cyril Hrubis
chrubis@suse.cz

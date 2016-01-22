From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 22 Jan 2016 12:15:38 +0300
Subject: [LTP] test.sh and ROD redirection
In-Reply-To: <20160121135150.GA18731@rei.lan>
References: <20160121135150.GA18731@rei.lan>
Message-ID: <56A1F33A.4000807@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,
On 01/21/2016 04:51 PM, Cyril Hrubis wrote:
> Hi!
> As I've been doing last minute fixes to shell testcases I've stambled
> upon this problem. We have a couple of places that do:
>
> ROD echo foo > bar
>
> And while this works fine if the command executes successfully it writes
> the error message to the file bar on failure as well (since the part
> that gets to the ROD as $@ is the 'echo foo' while the '> bar' is parsed
> by the shell.
>
> One solution would be redirecting the messages from tst_* to stderr, so
> we would be able to at least see the error message, but this wouldn't
> catch errors when we cannot write to the 'bar' (since echo foo would
> executed successfully anyway).
This won't work in case of simple file creation: ROD >file. Quotation 
marks seem to
help in this case with ROD.

./testcases/network/nfs/nfs_stress/nfs03:            ROD >file$j$k

can be changed to ROD ">file$j$k"

> Another solution would be to create ROD_ECHO and ROD_CAT and change ROD
> to abort if anybody tries to use it with these two. Which solves our
> usage pattern but this is clumsy and still broken as anyone can redirect
> output from ROD anyway.

Could be just one ROD_RED that accepts parameters in this way: 1st for 
exec and
the others to set after '>' redirection.

ROD_RED()
{
     $1 > ${@:2}
     if [ $? -ne 0 ]; then
     ....
}

ROD_RED "echo 0" "file"

Best regards,
Alexey

>
> Is there a elegant solution to this problem that I'm missing?

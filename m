Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MNwwI-00054P-ND
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:45:34 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNwwA-0000aM-Ie
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:45:34 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Tue, 7 Jul 2009 00:47:36 +0200
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
	<364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
In-Reply-To: <364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907070047.40979.jpalecek@web.de>
Subject: Re: [LTP] [PATCH] Fix some bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Monday 06 July 2009 19:45:08 Garrett Cooper wrote:
> Jiri,
>     This patch looks ok for the most part, but here are some comments:
> 
> 1. if [[ -z "$vnet0" -z "$vnet1" ]] => if [ -z "$vnet0" ] || [ -z "$vnet1" ]
> 
> It's better read as the following, IMO:
> 
> [ -z "$vnet0" -o -z "$vnet1" ]

I think this is another "I like this more than that, because this is cool and that sucks" debate. If other think test's "-o" should be used in this case, I would make the change. After all, this can be done by hand directly on the patch...

> 2. All numeric test(1) comparisons could and should be switched from:
> 
> command
> if [ $? = 0 ]; then
> 
> to:
> 
> if command; then
> 
> for brevity.

Why should them be changed? This is only a cosmetic change, which would make the patch unnecessarily larger (when it's already a little too large IMHO). If it could be in the former form till now, I think it can stay there a few months/years.

IMHO this usage is still much better than

 command; RC=$?
 if [ $RC = 0 ] ...
 ... RC is not read later ...

or (incorrect)

 command || RC=$?
 if [ $RC = 0 ] ...

> 3. About &>
> 
>    Redirecting Standard Output and Standard Error
>        Bash allows both the standard output (file descriptor 1) and
> the standard error output (file descriptor 2) to be redirected to the
> file whose name is the expansion of word with this construct.
> 
>        There are two formats for redirecting standard output and standard error:
> 
>               &>word
>        and
>               >&word
> 
> The output redirection above captures all output (and most of the time
> you're capturing stdout, but losing stderr to the operating console,
> which can be undesirable). >& is more portable IIRC (it works with
> many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
> -- IIRC), which makes it more ideal than &>.

Still, it isn't POSIX, it doesn't work with dash and actually causes pain. See:

 cmd &> fn

POSIX: run cmd in background, write empty file fn
BASH: run cmd (foreground), send its (normal & error) output to file fn

 cmd >& fn

POSIX: syntax error
BASH: same as above

But I don't see the point you are making here - do you have a system, where the POSIX way

 cmd > fn 2>&1

doesn't work? Or did you see something else in the patch?

Regards
    Jiri Palecek

BTW: Jiri Palecek <jirka@debian.org> is not my address.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

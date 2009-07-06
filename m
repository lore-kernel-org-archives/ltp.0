Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNvoA-0001Qd-Qx
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:33:06 +0000
Received: from an-out-0708.google.com ([209.85.132.251])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNsFa-0005Ya-5D
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:45:15 +0000
Received: by an-out-0708.google.com with SMTP id c38so1695669ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 10:45:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
References: <4a413e9b.160bca0a.2226.fffff184SMTPIN_ADDED@mx.google.com>
Date: Mon, 6 Jul 2009 10:45:08 -0700
Message-ID: <364299f40907061045s567f00dbq7a198ef37fa438dc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Jiri Palecek <jirka@debian.org>
Cc: ltp-list@lists.sourceforge.net

Jiri,
    This patch looks ok for the most part, but here are some comments:

1. if [[ -z "$vnet0" -z "$vnet1" ]] => if [ -z "$vnet0" ] || [ -z "$vnet1" ]

It's better read as the following, IMO:

[ -z "$vnet0" -o -z "$vnet1" ]

2. All numeric test(1) comparisons could and should be switched from:

command
if [ $? = 0 ]; then

to:

if command; then

for brevity.

3. About &>

   Redirecting Standard Output and Standard Error
       Bash allows both the standard output (file descriptor 1) and
the standard error output (file descriptor 2) to be redirected to the
file whose name is the expansion of word with this construct.

       There are two formats for redirecting standard output and standard error:

              &>word
       and
              >&word

The output redirection above captures all output (and most of the time
you're capturing stdout, but losing stderr to the operating console,
which can be undesirable). >& is more portable IIRC (it works with
many ash variants, like FreeBSD's sh -- for sure -- and Solaris's sh
-- IIRC), which makes it more ideal than &>.

Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

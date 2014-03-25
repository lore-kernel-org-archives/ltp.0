Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSTWU-0003SB-TV
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 15:44:18 +0000
Date: Tue, 25 Mar 2014 16:43:53 +0100
From: chrubis@suse.cz
Message-ID: <20140325154353.GB10754@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C548CD0@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C548CD0@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch for Debian distro testing, part 2 of 2
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I'm pretty sure I can minimize these further, maybe eliminate, given Cyril's comment yesterday to Alexey:
> >> +tdir="${LTPROOT}/testcases/bin/"
> > I keep telling everybody that this path must be part of the $PATH to 
> > run a LTP testcase so all binaries from it should be started just by 
> > their filename.
> 
> If this addition to $PATH is necessary, perhaps the wrapping scripts should enforce it,
> or the requirement noted in invocation instructions.  (So many invocation points, though ....)
> That plus shebanging these scripts as /bin/bash would eliminate the rest of this patch.

You are supposed to run the tests with correct PATH, in case that you
run tests from git checkout that would be:

PATH="$PATH:$PWD" ./foo

>  SSHD=`which sshd`
> diff --git a/testcases/kernel/containers/netns/initialize.sh b/testcases/kernel/containers/netns/initialize.sh
> index 1e66dc5..b2ad642 100755
> --- a/testcases/kernel/containers/netns/initialize.sh
> +++ b/testcases/kernel/containers/netns/initialize.sh
> @@ -49,13 +49,13 @@ if [ -n "${LTPROOT:-}" ]; then
>      fi
>  else
>      tst_resm TFAIL "Please set the LTP root env variable, and retry again"
> -    exit -1
> +    exit 255
>  fi

This was wrong to begin with, if test fails it should return 1

>  IPver=`ip -V | awk  -F"-" ' { print $2 } '` ;
>  if ! printf "%s\n%s\n" "ss080417" "$IPver" | sort -c ; then
>      tst_resm  TINFO "ip version should be atleast ss080417"
> -    exit -1
> +    exit 255
>  fi
>  i=1
>  while [ $i -le 6 ] ; do
> @@ -68,7 +68,7 @@ netdev=`ip addr show | awk '/^[0-9]*:.*UP/ { a=$2 } /inet / { b=$2 ; \
>  netdev=`basename $netdev ":"`
>  if [ -z "$netdev" ] ; then
>      tst_resm  TINFO "Not able to determine the ethernet dev name"
> -    exit -1
> +    exit 255
>  fi

And these are wrong too. Tests should not exit on TINFO. The first one
seems to be candidate for TCONF the second one is probably TBROK.

Description for the exit values can be see at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

The return values could be found in testcases/lib/test.sh

Also note that calling exit directly is deprecated and usage of the
test.sh library is prefered, but it's not required for changes in
existing tests.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

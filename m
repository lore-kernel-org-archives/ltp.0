Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrpxD-0004g2-4I
	for ltp-list@lists.sourceforge.net; Fri, 12 Aug 2011 11:31:07 +0000
Date: Fri, 12 Aug 2011 13:35:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110812113510.GA27650@saboteur.suse.cz>
References: <4E291159.20704@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E291159.20704@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ld: fix error with -m32 in x86_64
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> When making with -m32 in x86_64 kernel, ld should be set "LDEMULATION"
> environment variable to "elf_i386" or added "-m elf_i386" option.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/commands/ade/ld/ld01 |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/commands/ade/ld/ld01 b/testcases/commands/ade/ld/ld01
> index cf1d595..7c217d0 100755
> --- a/testcases/commands/ade/ld/ld01
> +++ b/testcases/commands/ade/ld/ld01
> @@ -44,6 +44,13 @@ TCdat=${TCdat:-`pwd`}
>  TCtmp=${TCtmp:-/tmp/ld-$$}
>  mkdir $TCtmp
>  
> +if [ "`uname -m`" == "x86_64" ]; then
> +	file $TCdat/ldmain.obj | grep 32-bit >/dev/null 2>&1
> +	if [ $? -eq 0 ]; then
> +		export LDEMULATION="elf_i386"
> +	fi
> +fi
> +

There seems to be a differently implemented check for similar problem
with ppc64, I would rather see these two merged into one. Eg testing for
any special -m xxx parameters at start and setting variable that is used
in tests.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

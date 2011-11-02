Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RLeUs-0002zC-JK
	for ltp-list@lists.sourceforge.net; Wed, 02 Nov 2011 17:21:06 +0000
Date: Wed, 2 Nov 2011 18:26:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111102172631.GA14582@saboteur.suse.cz>
References: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
Subject: Re: [LTP] [PATCH] runltp: fix printing of LTP Version
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fix function 'version_of_ltp' to reference Version in the correct path
> Fix Version's path when settign version_date
> 
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> ---
>  runltp |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/runltp b/runltp
> index 4ef8b38..244cd2f 100755
> --- a/runltp
> +++ b/runltp
> @@ -97,7 +97,7 @@ setup()
>  
>  version_of_ltp()
>  {
> -    cat "$LTPROOT/Version"
> +    cat "$LTPROOT/testcases/bin/Version"
>      exit 0
>  }
>  
> @@ -209,7 +209,7 @@ main()
>  
>      local scenfile=
>  
> -    version_date=$(cat "$LTPROOT/Version")
> +    version_date=$(cat "$LTPROOT/testcases/bin/Version")
>  
>      while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
>      do  case $arg in

Right, but there is one more thing to fix.

The Version is generated from Changelog, which is abandoned for some
time. But we introduced a VERSION file that carries latest version. So
the best woul be to drop Changelog completly and use the VERSION file
instead, anybody objects to that?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA&#174; Conference 2012
Save $700 by Nov 18
Register now&#33;
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

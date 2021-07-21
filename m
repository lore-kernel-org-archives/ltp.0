From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 17:07:45 +0200
Subject: [LTP] [PATCH v4 2/5] syscalls/msgstress01: Convert into new api
 and merge msgstress03 into it
In-Reply-To: <1615550541-21714-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201111163114.GB23576@yuki.lan>
 <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1615550541-21714-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YPg4QQ4D+Zm18ErR@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The code looks much better there are just two minor things.

> 2)Ignore SIGTERM instead of empty signhanlder and sighold/sigrelease

I wonder why do we ingore SIGTERM in the first place?

>  msgctl06 msgctl06
>  msgstress01 msgstress01
>  msgstress02 msgstress02
> -msgstress03 msgstress03
> +msgstress03 msgstress01 -n 10000 -l 10000
>  msgstress04 msgstress04
>  msgctl12 msgctl12
>  
> diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
> index 68fff4038..8adb686c1 100644
> --- a/runtest/syscalls-ipc
> +++ b/runtest/syscalls-ipc
> @@ -6,7 +6,7 @@ msgctl05 msgctl05
>  msgctl06 msgctl06
>  msgstress01 msgstress01
>  msgstress02 msgstress02
> -msgstress03 msgstress03
> +msgstress03 msgstress01 -n 10000 -l 10000

I'm also not sure if we should call it msgstress03, maybe it would be
cleaner if we named these two tests with msgstress01 with some suffix.

-- 
Cyril Hrubis
chrubis@suse.cz

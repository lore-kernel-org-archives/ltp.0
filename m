From: xieziyao <xieziyao@huawei.com>
Date: Tue, 20 Apr 2021 06:30:48 +0000
Subject: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown03.c with
 the new api
In-Reply-To: <YH2Z80HB8viimLOe@yuki>
References: <20210419013427.247615-1-xieziyao@huawei.com>
 <YH2Z80HB8viimLOe@yuki>
Message-ID: <6dbc2f45c2f44e41bd1971ed7a65367c@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks so much for your review!

I just re-checked the latest code and submit the v4 version based on your suggestions:
1. Move two similar owner checks to a single function;
2. Modify the incorrect code style.

Please see: https://patchwork.ozlabs.org/project/ltp/patch/20210420061954.155049-1-xieziyao@huawei.com/

Thanks very much!

Best Regards,
Ziyao

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Monday, April 19, 2021 10:56 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown03.c with the new api

Hi!
> +    SAFE_SETEUID(0);
> +    SAFE_CHOWN(FILENAME, -1, 0);
> +    SAFE_CHMOD(FILENAME, NEW_PERMS);
> +    SAFE_SETEUID(ltpuser->pw_uid);

LTP uses Linux kernel conding style which requires tabs for indentation, while this code uses four spaces.

You can use checkpatch.pl shipped along with Linux kernel sources to check coding style before sending patches to the list.

--
Cyril Hrubis
chrubis@suse.cz

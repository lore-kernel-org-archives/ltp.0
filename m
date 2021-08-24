From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 15:08:04 +0200
Subject: [LTP] [PATCH v7,
 4/4] Make argument to tst_umount an absolute path
In-Reply-To: <YSTj7CB6PdG2HZsQ@ubuntu02>
References: <YSTj7CB6PdG2HZsQ@ubuntu02>
Message-ID: <YSTvNANtOqYxNZSe@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	[ "$mounted" ] || return
> -	tst_umount $MNTDIR
> +	tst_umount $PWD/$MNTDIR

I guess that we should have the $PWD/$MNTDIR inside of double quotes
just to be extra careful.


Other than that with the chage proposed by Peter:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

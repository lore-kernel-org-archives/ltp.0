From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Aug 2021 14:56:12 +0200
Subject: [LTP] [PATCH v7,
 1/4] lib: tst_umount: umount a mount point instead of a device
In-Reply-To: <YSTjO2rjk9sWRSWD@ubuntu02>
References: <YSTjO2rjk9sWRSWD@ubuntu02>
Message-ID: <YSTsbAIgIyih05tb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		tst_res TINFO "The '$mntpoint' is not mounted upon, skipping umount"
                                                                 ^
								I would
								remove
								this
								'upon'
								here


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

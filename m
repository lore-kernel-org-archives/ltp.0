From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 May 2021 15:50:27 +0200
Subject: [LTP] [PATCH] Skip tmpfs in all-filesystem shell tests
In-Reply-To: <20210513134941.27656-1-mdoucha@suse.cz>
References: <20210513134941.27656-1-mdoucha@suse.cz>
Message-ID: <YJ0uo6YRyTsaNj0f@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> All-filesystem shell tests like LVM currently don't support tmpfs. Remove it
> from tst_supported_fs helper output for now.

git grep shows that we use that in zram01.sh and *_lvm.sh scripts, in
both cases tmpfs does not make any sense...

Looks good for the release:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

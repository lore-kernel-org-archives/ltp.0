From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jan 2020 17:46:53 +0100
Subject: [LTP] [PATCH] syscalls/capget02: Use pid=0 instead of getpid()
In-Reply-To: <9312b75d-7437-7274-6ec9-a05090cd86da@cn.fujitsu.com>
References: <1578553217-29510-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <6bd663d6-2ef4-cee8-1a5c-163dc2a74d8b@cn.fujitsu.com>
 <20200109095955.GC31981@rei.lan>
 <9312b75d-7437-7274-6ec9-a05090cd86da@cn.fujitsu.com>
Message-ID: <20200110164653.GB305583@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

FYI this was replaced by
https://patchwork.ozlabs.org/patch/1220805/
and merged as ad57b6090 syscalls/capget[set]: Make use of guarded buffers


Kind regards,
Petr

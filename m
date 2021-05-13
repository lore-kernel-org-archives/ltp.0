From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 May 2021 18:00:32 +0200
Subject: [LTP] [PATCH] Skip tmpfs in all-filesystem shell tests
In-Reply-To: <YJ0uo6YRyTsaNj0f@yuki>
References: <20210513134941.27656-1-mdoucha@suse.cz>
 <YJ0uo6YRyTsaNj0f@yuki>
Message-ID: <YJ1NICB0Y9gdnpQw@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Cyril

> Hi!
> > All-filesystem shell tests like LVM currently don't support tmpfs. Remove it
> > from tst_supported_fs helper output for now.

> git grep shows that we use that in zram01.sh and *_lvm.sh scripts, in
> both cases tmpfs does not make any sense...

> Looks good for the release:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Good point, thanks! I also think it's good for a release. But in the future I'd
like to take single NFS test and run it in all filesystems. Currently there is
ongoing work to fix tmpfs on NFS. So we might need to move this skip in the
future to respected tests (zram01.sh and *_lvm.sh). And for that we will have
to implement skip filesystem for shell (or just skip it "manually").

Kind regards,
Petr

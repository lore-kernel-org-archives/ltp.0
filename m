From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 May 2021 10:12:36 +0200
Subject: [LTP] [PATCH] Skip tmpfs in all-filesystem shell tests
In-Reply-To: <YJ1NICB0Y9gdnpQw@pevik>
References: <20210513134941.27656-1-mdoucha@suse.cz> <YJ0uo6YRyTsaNj0f@yuki>
 <YJ1NICB0Y9gdnpQw@pevik>
Message-ID: <YJ4w9JHPC8W7Xe3Y@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Good point, thanks! I also think it's good for a release. But in the future I'd
> like to take single NFS test and run it in all filesystems. Currently there is
> ongoing work to fix tmpfs on NFS. So we might need to move this skip in the
> future to respected tests (zram01.sh and *_lvm.sh). And for that we will have
> to implement skip filesystem for shell (or just skip it "manually").

Sure, we should implement a proper skiplist later on once it's needed.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

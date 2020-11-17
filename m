From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 17 Nov 2020 14:05:38 +0100
Subject: [LTP] [PATCH 5.9 198/255] loop: Fix occasional uevent drop
In-Reply-To: <20201117122138.925150709@linuxfoundation.org>
References: <20201117122138.925150709@linuxfoundation.org>
Message-ID: <20201117122148.567147400@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

commit c01a21b77722db0474bbcc4eafc8c4e0d8fed6d8 upstream.

Commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
causes an occasional drop of loop device uevent, which are no longer
triggered in loop_set_size() but in a different part of code.

Bug is reproducible with LTP test uevent01 [1]:

i=0; while true; do
    i=$((i+1)); echo "== $i =="
    lsmod |grep -q loop && rmmod -f loop
    ./uevent01 || break
done

Put back triggering through code called in loop_set_size().

Fix required to add yet another parameter to
set_capacity_revalidate_and_notify().

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/uevents/uevent01.c

[hch: rebased on a different change to the prototype of
 set_capacity_revalidate_and_notify]

Cc: stable@vger.kernel.org # v5.9
Fixes: 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
Reported-by: <ltp@lists.linux.it>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -255,7 +255,8 @@ static void loop_set_size(struct loop_de
 
 	bd_set_size(bdev, size << SECTOR_SHIFT);
 
-	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
+	if (!set_capacity_revalidate_and_notify(lo->lo_disk, size, false))
+		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 }
 
 static inline int



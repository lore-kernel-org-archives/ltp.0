From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Oct 2020 19:49:26 +0100
Subject: [LTP] Ocassional dropping of uevent of loop device (possible race)
Message-ID: <20201027184926.GA24024@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify()")
from v5.8-rc1 caused occasional dropping of uevent of attached or detached loop
device (not sure which one). The only difference is that
set_capacity_revalidate_and_notify() has condition:
if (capacity != size && capacity != 0 && size != 0)
thus notification is not triggered here but in a different part of code.

It was found with LTP test uevent01 [1]:

# i=0; while true; do i=$((i+1)); echo "== $i =="; rmmod -f loop; ./uevent01 || break; done

It looks to be a race. Usually ~ 10 loops is enough.

Kind regards,
Petr

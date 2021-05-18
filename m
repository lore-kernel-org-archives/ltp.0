From: Li Wang <liwang@redhat.com>
Date: Tue, 18 May 2021 15:54:20 +0800
Subject: [LTP] LTP pre-release git freeze and call for testing
In-Reply-To: <YJz4A3mR3jHciihe@yuki>
References: <YJOYgZNL7/qp5YCN@yuki> <YJpq26w8NBvBzUSc@yuki>
 <YJz4A3mR3jHciihe@yuki>
Message-ID: <CAEemH2eo7LOvz0LBwuaNkM2aRRWxD_rErOWFyHjVOpRB3oNCsw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> As previously planned LTP git is now frozen for anything but imporatnt
> fixes and the (ideally) week of pre-release testing starts now.
>
> If you haven't tested latest LTP git please do so now.

FYI:

Tested the latest LTP branch on RHEL8 (with itself kernel-4.18~ and
mainline kernel-v5.13-rc1), the result looks pretty good to me.

Mainline kernel:
  mkswap01 6 TBROK: "check_for_file /dev/disk/by-label/ltp_testswap" timed out
    - looks like hit the race condition issue as before
  hugemmap05.c:84: TBROK: mmap((nil),2147483648,3,1,3,0) failed: ENOMEM (12)
    - seems caused by memory fragmentation, not a big deal

RHEL8:
  mkswap01: same as above
  bpf_prog05: known unfix bug
  semctl09: known glibc bug
  fanotify09/10: known unfix bug


-- 
Regards,
Li Wang


From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Dec 2017 18:19:07 +0800
Subject: [LTP] [PATCH v2 2/2] ioctl: convert ioctl03 to new API
In-Reply-To: <20171219134138.GF28293@rei>
References: <20171214072432.15709-1-liwang@redhat.com>
 <20171214072432.15709-2-liwang@redhat.com>
 <20171219134138.GF28293@rei>
Message-ID: <CAEemH2eb8R8BAYV1_kw0KX=SH89HR5mevzHWK_nds+1m_zp0Fw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 19, 2017 at 9:41 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>> +     SAFE_IOCTL(netfd, TUNGETFEATURES, &features);
>> -
>> -     if (ioctl(netfd, TUNGETFEATURES, &features) != 0)
>> -             tst_brkm(TCONF, cleanup,
>> -                      "Kernel does not support TUNGETFEATURES");
>
> After this change the test fails with TBROK instead of TCONF when the
> ioctl() fails.
>
> I suppose that the tun driver can be compiled out of the kernel and that
> we should still handle this situation as TCONF rather than TBROK. The
> question is what kind of errno we get in that case, I suppose that it
> may be ENOTTY but that should be tested.

Do you mean that ioctl(netfd, TUNGETFEATURES, &features) may be failed
with erron==ENOTTY while testing on a kernel without TUN driver
loaded?

I tried that with kernel-4.15-rc4 but get "No Such Device" error when
open "/dev/net/tun" file. And the worth to say, /dev/net/tun is still
exist after removing TUN module.


=========
# uname -r
4.15.0-rc4

# rmmod tun

# ll /dev/net/tun
crw-rw-rw-. 1 root root 10, 200 Dec 20 04:59 /dev/net/tun

# ./ioctl03
tst_test.c:977: INFO: Timeout per run is 0h 05m 00s
safe_macros.c:225: BROK: ioctl03.c:82: open(/dev/net/tun,2,063200020)
failed: ENODEV


Thanks for reviewing patiently. I'm OK with the rest comments.

-- 
Li Wang
liwang@redhat.com

From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Sep 2020 16:20:45 +0800
Subject: [LTP] [PATCH] clock_gettime04: relax the time diff in VM
In-Reply-To: <20200915081032.GA8111@yuki.lan>
References: <20200915031402.26519-1-liwang@redhat.com>
 <20200915081032.GA8111@yuki.lan>
Message-ID: <CAEemH2d4SehT7xV9sa1t5tZDtVRQKf4MaE3VokWYhE5gwk_jGA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> od, but I think that the implementation could be better.
>
> Why can't we just call the tst_is_virt() in test setup and if we detect
> that we are running on virtual machine print a TINFO message that
> maximal expected difference has been multiplied by 10?
>

Sounds good.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200915/092fe1b8/attachment.htm>

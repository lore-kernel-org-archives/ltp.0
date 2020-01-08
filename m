From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jan 2020 12:41:41 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
Message-ID: <20200108114141.GB17272@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> Btw I just pushed a simple fix to include unistd.h, it seems not works.

You would need to define _GNU_SOURCE at the top of each test that uses
it otherwise the definition is not exposed.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 8 Jan 2020 12:45:45 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200108114141.GB17272@rei.lan>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
 <20200108114141.GB17272@rei.lan>
Message-ID: <20200108114545.GA28867@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Cyril,

> Hi
> > Btw I just pushed a simple fix to include unistd.h, it seems not works.

> You would need to define _GNU_SOURCE at the top of each test that uses
> it otherwise the definition is not exposed.
Yep :(. I join to Cyril's vote for raw syscall.
BTW please test it with travis or locally build.sh script (which adds
-Werror=implicit-function-declaration).

I guess we should work on travis CI integration so we don't have to push it to
travis manually [1].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/599

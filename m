From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 09:27:44 +0200
Subject: [LTP] [PATCH] zram01: Fix division by 0
In-Reply-To: <CAEemH2f5XQZw-1hP7ffNYFUtPcBW7TujgkGjN5T0NBa5gnx_AQ@mail.gmail.com>
References: <20190731063320.4898-1-pvorel@suse.cz>
 <CAEemH2f5XQZw-1hP7ffNYFUtPcBW7TujgkGjN5T0NBa5gnx_AQ@mail.gmail.com>
Message-ID: <20190731072744.GA9043@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > +       if [ $used_mem -eq 0 ]; then
> > +               tst_resm TBROK "no memory used by zram"
> > +               return
> > +       fi

> Why not use tst_brkm directly? Otherwise looks good to me.
Make sense.
Thanks for your ack, lets wait for Alexey.

I wonder how this can happen (found occasionally on ppc64le).

If this happen than zram02 and zram03 fails on timeout:
/opt/ltp/testcases/bin/zram_lib.sh: line 38: echo: write error: Device or resource busy
zram03      1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/block/zram0/disksize' at zram03.c:87: errno=EBUSY(16): Device or resource busy

Maybe some timeout would help, need to look into it.

Petr

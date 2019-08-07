From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Aug 2019 17:16:42 +0300
Subject: [LTP] [PATCH] zram01: Fix division by 0
In-Reply-To: <20190731072744.GA9043@x230>
References: <20190731063320.4898-1-pvorel@suse.cz>
 <CAEemH2f5XQZw-1hP7ffNYFUtPcBW7TujgkGjN5T0NBa5gnx_AQ@mail.gmail.com>
 <20190731072744.GA9043@x230>
Message-ID: <75d2ba6f-447d-8982-0404-df3100073d5c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 31.07.2019 10:27, Petr Vorel wrote:
> Hi Li,
> 
>>> +       if [ $used_mem -eq 0 ]; then
>>> +               tst_resm TBROK "no memory used by zram"
>>> +               return
>>> +       fi
> 
>> Why not use tst_brkm directly? Otherwise looks good to me.
> Make sense.
> Thanks for your ack, lets wait for Alexey.
> 
> I wonder how this can happen (found occasionally on ppc64le).
> 

Is it actually working, i.e. writing to zram?

      while true; do
          dd conv=notrunc if=/dev/zero of=zram${i}/file \
             oflag=append count=1 bs=1024 status=none \
             > /dev/null 2>&1 || break
          b=$(($b + 1))
      done
      tst_resm TINFO "zram$i can be filled with '$b' KB"

Perhaps, we could add a check for the minimum value of $b and print
the last error from dd too...

> If this happen than zram02 and zram03 fails on timeout:
> /opt/ltp/testcases/bin/zram_lib.sh: line 38: echo: write error: Device or resource busy
> zram03      1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/block/zram0/disksize' at zram03.c:87: errno=EBUSY(16): Device or resource busy
> 
> Maybe some timeout would help, need to look into it.
> 
> Petr
> 


From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 29 Jun 2020 18:37:51 +0800
Subject: [LTP] [PATCH v4 1/2] tst_device: Add new api
 tst_find_backing_dev(path, dev)
In-Reply-To: <1418968619.19068649.1593417390787.JavaMail.zimbra@redhat.com>
References: <20200624113217.GC30917@yuki.lan>
 <1593330123-19631-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1418968619.19068649.1593417390787.JavaMail.zimbra@redhat.com>
Message-ID: <c11e8d9b-bd16-da32-e9eb-490226f4f4c1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan


> 
> 
> ----- Original Message -----
>> +This function finds the block dev that this path belongs to, it compares
>> path buf
>> +with the fifth column of each row in "/proc/self/mountinfo" and list 10th
>> column
>> +as its block dev.
> 
> Why not match major/minor numbers?
> 
> You said "But stat function has problem when filsystem uses virtual block
> (such as btrfs,fuse, then major numer is 0)." - Why is that a problem
> for comparison against /proc/self/mountinfo?
> 
Yes, you are right. I wrongly think btrfs filesystem affects the 10th 
columu value in /proc/self/mountinfo. In actually, it can show the 
correct backing block dev.
so this functon code as below:
void tst_find_backing_dev(const char *path, char *dev)
{
         char fmt[1024];
         struct stat buf;

         if (stat(path, &buf) < 0)
                  tst_brkm(TWARN | TERRNO, NULL, "stat() failed");

         snprintf(fmt, sizeof(fmt), "%%*i %%*i %u:%u %%*s %%*s %%*s %%*s 
%%*s %%*s %%s %%*s",
                         major(buf.st_dev), minor(buf.st_dev));

         SAFE_FILE_LINES_SCANF(NULL, "/proc/self/mountinfo", fmt, dev);

         if (stat(dev, &buf) < 0)
                  tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);

         if (S_ISBLK(buf.st_mode) != 1)
                 tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
}


ps: If you think it is ok, I will send a v5 patch about this.
> 
> 



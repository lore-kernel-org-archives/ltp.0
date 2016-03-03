From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Thu, 03 Mar 2016 17:43:05 +0800
Subject: [LTP] [PATCH] commands/mkswap01: Update wait_for_file function
In-Reply-To: <56D7FCD8.3070000@oracle.com>
References: <1454082985-3549-1-git-send-email-shuang.qiu@oracle.com>
 <20160202143525.GC19199@rei.lan> <56B157DB.3010206@oracle.com>
 <20160204131705.GD4615@rei> <56CF3128.7030509@oracle.com>
 <20160302134200.GA25763@rei> <56D7FCD8.3070000@oracle.com>
Message-ID: <56D80729.5030105@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/03/2016 04:59 PM, Stanislav Kholmanskikh wrote:
>
>
> On 03/02/2016 04:42 PM, Cyril Hrubis wrote:
>> Hi!
>>> Hmm, in my case swapon -L test does not fail, if there is no
>>> /dev/disk/by-label/test:
>>>
>>> root@skholman-m7 stas]# rm /dev/disk/by-label/test
>>> rm: remove symbolic link `/dev/disk/by-label/test'? y
>>> [root@skholman-m7 stas]# BLKID_FILE=/tmp/none strace swapon -L test &>
>>> /tmp/o; echo $?
>>> 0
>>> [root@skholman-m7 stas]# grep by-label /tmp/o
>>> stat64("/dev/disk/by-label/test", 0x7feff9b6130) = -1 ENOENT (No such
>>> file or directory)
>>> [root@skholman-m7 stas]#
>>>
>>> (but in the strace output I see that swapon tries to read some sectors
>>> from all available block devices)
>>>
>>> Maybe the version of libblkid plays a role here.
>>>
>>> Using 'blkid -t' simply makes wait_for_file/wait_for_device not fail if
>>> there is no /dev/disk/by-label/ symlink. I suppose 'blkid -t' could be
>>> substituted with /bin/true in my case.
>>
>> Unfortunately for me the swapon just looks for the symlink
>> (util-linux-2.19.1) while blkid -t also reads first 512 bytes of each
>> block device. So I guess that using blkid will not help in this case.
>>
>> Then what about just changing the 'tst_resm TWARN "The file $path
>> haven't appeared"' from TWARN to TINFO?
>
> Well, no objections then. Even if there is no symlink created in time 
> we call swapon, swapon will not fail on our systems, but wait_for_file 
> will still provide extra 10*10ms for the symlink to be created on your 
> systems.
>
> Shuang ?
It is ok for me too.
I did not find any other issue if change TWARN to TINFO.

Thanks
Shuang


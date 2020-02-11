From: Xiao Yang <ice_yangxiao@163.com>
Date: Tue, 11 Feb 2020 18:25:02 +0800
Subject: [LTP] test with aio02 is failing with safe_macros.c:223: BROK:
 aio02.c:130: open(file, 16961, 0644) failed: EINVAL (22)
In-Reply-To: <BMXPR01MB2999C5C6166A34812CFA3727EE180@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB29991144C5DF1108F9B38DD9EE180@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
 <f6cf7d37-cf31-7448-0bea-035eb48f2f79@163.com>
 <BMXPR01MB2999C5C6166A34812CFA3727EE180@BMXPR01MB2999.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <6e81635f-c202-9f41-6795-4d6f84290e7e@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 2/11/20 6:01 PM, Pankaj Vinadrao Joshi wrote:
> Hi sir,
> I am begginer can you tell how i can? check if tmpfs is mounted on 
> /tmp in your enviroment?

Hi,


You can use df/mount command to do check, as below:

-----------------------------------------------------------------

[root@Fedora-30-vm linux]# df -h | grep '/tmp'
tmpfs?????????? 993M? 4.0K? 993M?? 1% /tmp

[root@Fedora-30-vm linux]# mount | grep '/tmp'
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel)

------------------------------------------------------------------

>
> Sir if you have two minutes of time can you elaborate it whats its 
> meaning?

aio02 uses open(O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | O_CREAT) to

create test file in default /tmp directory and ****O_DIRECT flag may not 
be supported

by tmpfs so calling open() returns EINVAL.


Thanks,

Xiao Yang

>
>
> Thank you ?
> ------------------------------------------------------------------------
> *From:* Xiao Yang <ice_yangxiao@163.com>
> *Sent:* Tuesday, February 11, 2020 3:04 PM
> *To:* Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> *Subject:* Re: [LTP] test with aio02 is failing with 
> safe_macros.c:223: BROK: aio02.c:130: open(file, 16961, 0644) failed: 
> EINVAL (22)
>
> Hi,
>
>
> Could you check if tmpfs is mounted on /tmp in your enviroment?
>
> It seems that tmpfs cannot support O_DIRECT flag and creating file 
> with O_DIRECT in tmpfs triggers the error.
>
> Perhaps, you can fix the error by mounting normal filesystem(e.g. 
> ext4/xfs) on /tmp for now.
>
>
> Thanks,
>
> Xiao Yang
>
> On 2/11/20 4:31 PM, Pankaj Vinadrao Joshi wrote:
>> Hi,
>> i am running aio02 test on my RISC v machine,my testing is getting 
>> failed with the message
>> *safe_macros.c:223: BROK: aio02.c:130: open(file,16961,0644) failed: 
>> EINVAL (22)*
>>
> [EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200211/2192be1b/attachment.htm>

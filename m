From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 4 Nov 2015 13:37:45 +0800
Subject: [LTP] [PATCH v2] commands/mkfs: Added new testcase to test
 mkfs(8) command.
In-Reply-To: <BLU436-SMTP294FE375F1A0F67CEFCDAACF2A0@phx.gbl>
References: <56385136.8060007@cn.fujitsu.com>
 <1446551007-7826-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <BLU436-SMTP294FE375F1A0F67CEFCDAACF2A0@phx.gbl>
Message-ID: <563999A9.1090507@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

>> +mkfs_verify_type()
>> +{
>> +    if [ -z "$1" ]; then
>> +        blkid $2 | grep -q "ext2"
>> +    else
>> +        blkid $2 | grep -q "$1"
>> +    fi
>> +}
> 
> Hi, how about:
> mkfs_verify_type()
> {
>     if [ -z "$1" ]; then
>         blkid $2 -t TYPE="ext2"
>     else
>         blkid $2 -t TYPE="$1"
>     fi
> }
> 

It looks better since it's more logical? thanks!

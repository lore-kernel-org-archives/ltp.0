From: zhaogongyi <zhaogongyi@huawei.com>
Date: Fri, 5 Feb 2021 08:43:33 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSB0dHlwZTogdXNpbmcgVEVSUk5P?=
 =?utf-8?q?_to_macth_errno?=
In-Reply-To: <CAEemH2fb8vHKoU-04izd0EqBz9fF2TGjE3ABaXtGkRdPxbU=Sg@mail.gmail.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40385FF8E@dggeml531-mbx.china.huawei.com>
 <CAEemH2fb8vHKoU-04izd0EqBz9fF2TGjE3ABaXtGkRdPxbU=Sg@mail.gmail.com>
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB403860217@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

The check script may be as follows:

#!/bin/bash

grep TTERRNO . -rn -B 3 --exclude=grep.output --exclude=check.sh > grep.output

##Prepare for checking line by line
sed -i '1i\--' grep.output

do_check()
{
        grep TEST $i && return 0
        grep TST_RET $i && return 0
        grep TST_ERR $i && return 0
        grep TEST_RETURN $i && return 0
        return 1
}

start=0
i=0
while read line
do
        echo $line | grep \\\-\\\-
        ret=$?
        if [ $ret -eq 0 -a $start -eq 0 ];then
                        start=1
                        continue
        fi
        if [ $ret -eq 0 -a $start -eq 1 ];then
                start=0
                do_check $i
                if [ $? -eq 0 ];then
                        rm $i
                fi
                let i=$i+1
                continue
        fi
        echo $line >> $i
done < grep.output


Thank You

???: Li Wang [mailto:liwang@redhat.com]
????: 2021?2?5? 12:38
???: zhaogongyi <zhaogongyi@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] ttype: using TERRNO to macth errno

Hi Gongyi,

Thanks for your work!

That'd be awesome if you posting/sharing the method of your script too.

On Fri, Feb 5, 2021 at 11:44 AM zhaogongyi <zhaogongyi@huawei.com<mailto:zhaogongyi@huawei.com>> wrote:
Hi Li

The problem of wrong usage of TTERRNO has been checked all of the project by my local script.

The problem of wrong usage of TERRNO will be fixed in my next patch.

Thank You

???: Li Wang [mailto:liwang@redhat.com<mailto:liwang@redhat.com>]
????: 2021?2?5? 10:49
???: zhaogongyi <zhaogongyi@huawei.com<mailto:zhaogongyi@huawei.com>>
??: LTP List <ltp@lists.linux.it<mailto:ltp@lists.linux.it>>
??: Re: [LTP] [PATCH] ttype: using TERRNO to macth errno

Hi Gongyi,

Any possibility of finding a way to correct all of the unprecise res-flags in LTP tests?

--
Regards,
Li Wang


--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210205/06e3aaef/attachment-0001.htm>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: check.sh
Type: application/octet-stream
Size: 602 bytes
Desc: check.sh
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210205/06e3aaef/attachment-0001.obj>

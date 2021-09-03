From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 3 Sep 2021 06:28:42 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
In-Reply-To: <YTDpQxDDPY3HCli6@pevik>
References: <20210902103740.19446-1-pvorel@suse.cz>
 <015140e9-0eba-4057-4a91-35d958af2bb8@jv-coder.de> <YTDpQxDDPY3HCli6@pevik>
Message-ID: <16028467-ecd5-ecc0-26d7-b7a617045970@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

H Petr,

On 9/2/2021 5:09 PM, Petr Vorel wrote:
>
>> $ checkbashisms testcases/kernel/connectors/pec/cn_pec.sh
>> possible bashism in testcases/kernel/connectors/pec/cn_pec.sh line 127
>> (should be >word 2>&1):
>>  ??????????????? done <&${fd_act}
>> This one is just a false positive and I have no clue how to prevent this.
>> I think the script does not like the <&, but this is posix...
> The same here, I'm not sure if it's POSIX. &> definitely is not POSIX.
> I remember we were talking about it. Can we avoid it somehow?
<&n is the only way to use the file handle n for input. <n would use the 
file n.
See: 
https://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_07_05

checkbashisms has no problems if n is a number, not a variable. There is 
nothing in the standard about n being a variable, but I guess this 
should be posix as well.
Furthermore the suggested fix "(should be >word 2>&1)" clearly shows, 
that checkbashisms thinks, this is &>.

I don't see another way to implement this (but using an implementation 
in c). And I am not really happy to bend my code around bugs in a tool, 
that is supposed to ensure better code.
I'd rather try to fix checkbashims in this case. Even the ((-case should 
be fixed, after checking if it is posix. The suggestion (replace with 
"$((") indicates at least a bug in the tool.
To be honest, I am a bit disappointed from this tool. It doesn't seem to 
be tested very well... Probably barely good enough for scripting in the 
kernel.

Joerg

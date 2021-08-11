From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 11 Aug 2021 17:19:44 +0200
Subject: [LTP] [PATCH 1/2] shell: Add checkpoints api for new lib
In-Reply-To: <YRPGHBuKHnvARkn+@yuki>
References: <20210809121238.1585673-1-lkml@jv-coder.de> <YRPGHBuKHnvARkn+@yuki>
Message-ID: <e8325b2c-36b3-a865-d48a-7ad5a8a095cb@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 8/11/2021 2:44 PM, Cyril Hrubis wrote:
>
>> +_tst_init_checkpoints()
>> +{
>> +	local pagesize
>> +
>> +	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
>> +	pagesize=$(tst_getconf PAGESIZE)
>> +	if [ $? -ne 0 ]; then
>> +		tst_brk TBROK "tst_getconf PAGESIZE failed"
>> +	fi
>> +	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
>> +	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
>> +	export LTP_IPC_PATH
>> +}
> Shouldn't we also delete the /dev/shm/ltp_${TCID}_$$ in the
> _tst_do_exit() if LTP_IPC_PATH was set?
You are right of course... I was in a tst_tmpdir mindset when 
implementing it, sorry.
I'll send a v2
>
> Other than that it looks fine.

Joerg

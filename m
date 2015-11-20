From: yangxiao <yangx.jy@cn.fujitsu.com>
Date: Fri, 20 Nov 2015 11:10:03 +0800
Subject: [LTP] [PATCH] controllers/cpuacct: add kernel version check
In-Reply-To: <20151119120501.GC28969@rei.lan>
References: <1447926563-26726-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20151119120501.GC28969@rei.lan>
Message-ID: <564E8F0B.5090208@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi !
> Hi!
>>   	tst_require_root
>>
>> +	tst_kvercmp 2 6 30
>> +	if [ $? -eq 0 ]; then
>> +		tst_brkm TCONF "Test should be run with kernel 2.6.30 or newer"
>> +	fi
> Can we do 'grep -q cpuacct /proc/cgroups' to figure out if it's
> supported instead?
>
Thanks, I will rewirte it as what you suggested.

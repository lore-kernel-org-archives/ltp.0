From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 5 Nov 2015 10:03:54 +0800
Subject: [LTP] [PATCH v3] commands/mkfs: Added new testcase to test
 mkfs(8) command.
In-Reply-To: <20151104132206.GD17823@rei>
References: <5638A0B2.1060600@cn.fujitsu.com>
 <1446624763-3242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20151104132206.GD17823@rei>
Message-ID: <563AB90A.6040202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/11/04 21:22, Cyril Hrubis wrote:
> Hi!
>> +mkfs_verify_size()
>> +{
>> +	mkfs_mount
>> +	local blocknum=`df -B 1k mntpoint | tail -n1 | awk '{print $2}'`
>> +	mkfs_umount
>> +
>> +	if [ $blocknum -gt "$2" ]; then
>> +		return 1
>> +	fi
>> +
>> +	# Size argument in mkfs.ntfs denotes number-of-sectors which is 512bytes,
>> +	# 1k-block size should be devided by this argument for ntfs verification.
>> +	if [ "$1" = "ntfs" ]; then
>> +		local rate=1024/512
>> +		if [ $blocknum -lt "$(($2/rate*9/10))" ]; then
>> +			return 1
>> +		fi
>> +	else
>> +		if [ $blocknum -lt "$(($2*9/10))" ]; then
>> +			return 1
>> +		fi
>> +	fi
> 
> I've added explicit return 0 here, since otherwise the retul value would
> be set by the last executed command (which would be the either umount
> or mount above...).
> 

Indeed, got it.
Many thanks!

Best Regards,
Guangwen Feng

> 
> And pushed, thanks.
> 

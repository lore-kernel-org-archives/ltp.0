From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 14 Jan 2019 13:11:14 +0000
Subject: [LTP] [PATCH]  Fix cgroup_lib.sh helper
In-Reply-To: <20190114124206.GA17760@dell5510>
References: <20190111161017.52307-1-cristian.marussi@arm.com>
 <20190114124206.GA17760@dell5510>
Message-ID: <59a71c55-4553-de0c-7781-c3f7bee75dca@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 14/01/2019 12:42, Petr Vorel wrote:
> Hi Cristian,
> 
> ...
>>  	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
>> -	[ -z "$mountpoint" ] && return 1
>> +	[ -z "$mntpoint" ] && return 1
> Thanks for fix, merged.
> 
> I'm sorry, that was introduced by me, while do some changes in your commit.

No problem.
> 
> 
> Kind regards,
> Petr
> 

Thanks

Regards

Cristian


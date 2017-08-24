From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 24 Aug 2017 21:25:24 +0800
Subject: [LTP] [PATCH 2/2] syscalls/keyctl: Make use of lapi/keyctl.h &&
 Add existing test to runtest/cve
In-Reply-To: <20170823141800.GC20766@rei.lan>
References: <20170823110032.1795-1-fenggw-fnst@cn.fujitsu.com>
 <20170823110032.1795-2-fenggw-fnst@cn.fujitsu.com>
 <20170823141800.GC20766@rei.lan>
Message-ID: <ac931c16-d892-fb72-0ac5-83655c116cad@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

Thanks for your review!

在 08/23/2017 10:18 PM, Cyril Hrubis 写道:
> Hi!
>> -	keyctl(KEYCTL_READ, key, buffer, 4);
>> +	tst_syscall(__NR_keyctl, KEYCTL_READ, key, buffer, 4);
> 
> What about we, instead of using raw syscall, defined fallback keyctl()
> and add_key() in the lapi/keyctl.h that would call the syscall? That way
> we would test the keyutils library if present but these tests will not
> be disabled otherwise.
> 

Yes, that sounds good, thanks!

Best Regards,
Guangwen Feng



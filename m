From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 2 Mar 2020 16:08:38 +0800
Subject: [LTP] netns_netlink test failure
In-Reply-To: <MAXPR0101MB14686629CA22EDA8E38CBE6AEEE70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14681590CE13BB4E2ED97CFEEEE80@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <20200228092107.GB31181@rei>
 <MAXPR0101MB1468032C8109347B258800B7EEE70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <42474632-110d-bf91-f9da-37b16f8e6fed@cn.fujitsu.com>
 <MAXPR0101MB14686629CA22EDA8E38CBE6AEEE70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <84d11eec-f182-3e14-ec0b-8909b22d8281@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

CC LTP mail list, you may get more info from others.
> Hi,
> sir, have tried this it giving error with folloeing message
> 
> root@exaleapsemi:~/pankaj_ltp# ip tuntap add dev dummy0 mode tap
> open: No such file or directory
It looks like your environment misses /dev/net/tun devfile, you should 
check your kernel config and set "CONFIG_TUN=y/m".

Best Regards
Yang Xu
> 
> Thanks
> ------------------------------------------------------------------------
> *From:* Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> *Sent:* Monday, March 2, 2020 11:11 AM
> *To:* Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> *Cc:* Cyril Hrubis <chrubis@suse.cz>; ltp@lists.linux.it
> <ltp@lists.linux.it>
> *Subject:* Re: [LTP] netns_netlink test failure
> Hi
> 
>> Hi,
>> What could be the possible reason behind failing,any guess??
> At lease, you should attach this command output.
> # ip tuntap add dev dummy0 mode tap
> 
> Best Regards
> Yang Xu
>> ------------------------------------------------------------------------
>> *From:* Cyril Hrubis <chrubis@suse.cz>
>> *Sent:* Friday, February 28, 2020 2:51 PM
>> *To:* Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
>> *Cc:* ltp@lists.linux.it <ltp@lists.linux.it>
>> *Subject:* Re: [LTP] netns_netlink test failure
>> Hi!
>>> <<<test_output>>>
>>> open: No such file or directory
>>> netns_netlink??? 1? TBROK? :? netns_netlink.c:143: system() failed
>>?????????????????????????????????????????????????? ^
>>?????????????????????????????????????????????????? This is a line number,
>>?????????????????????????????????????????????????? if you look a the
>>?????????????????????????????????????????????????? source code of the
>>?????????????????????????????????????????????????? test, you see:
>>
>>????????? if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
>>????????????????? tst_brkm(TBROK, cleanup, "system() failed");
>>
>> So that the failed command was "ip tuntap add dev dummy0 mode tap", it's
>> up to
>> you to figure out why...
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>> [EXT]
>>
>>
> 
> 
> [EXT]



From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Aug 2021 16:15:11 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2021-3609
In-Reply-To: <YSY1oaE3794Asrp8@yuki>
References: <20210825104300.15255-1-mdoucha@suse.cz>
 <20210825104300.15255-3-mdoucha@suse.cz> <87k0k9lpld.fsf@suse.de>
 <025997b0-e0a8-d450-e387-f1a2e8a720e9@suse.cz> <YSY1oaE3794Asrp8@yuki>
Message-ID: <57a4f942-a97e-c82b-8a63-1da862eca168@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25. 08. 21 14:20, Cyril Hrubis wrote:
> Hi!
>>> I think you dropped NS due to lack of CAN support on older kernels?
>>
>> Exactly. If I create a new network namespace, SAFE_SOCKET() will fail
>> with EAFNOSUPPORT on kernel 4.4.
> 
> Then I guess that we have to remove the needs_kconfig before pushing,
> right?

Yes, please. I forgot to remove needs_kconfig after rewriting setup()
and cleanup() 5 times...

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

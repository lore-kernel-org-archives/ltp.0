From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 13 Sep 2021 11:12:23 +0200
Subject: [LTP] [PATCH 8/8] syscalls/setresuid03: Convert to new API
In-Reply-To: <YTtrwkSdUaQE/PnB@yuki>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-8-mdoucha@suse.cz>
 <287a9879ef8b3342cb88225e4e319733@suse.de> <YTtrwkSdUaQE/PnB@yuki>
Message-ID: <6335b5af-908f-e2be-8f79-f109a2ba5c45@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10. 09. 21 16:29, Cyril Hrubis wrote:
> Hi!
>> It's a second test where we could use TST_EXP_FAIL_SILENT() if we had it 
>> defined.
> 
> Well the main point we test is that the call fails so I would just use
> TST_EXP_FAIL() that produces TPASS/TFAIL and the have additional check
> if the groups were changed or not.
> 
> I can change the patche accordingly before applying if you agree.

I didn't use TST_EXP_FAIL() intentionally in order to have the same test
output as with TST_EXP_PASS_SILENT(). But I can use TST_EXP_FAIL() as
well. The final UID/GID check needs some changes too so I'll resubmit.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 10 Nov 2020 12:52:04 +0100
Subject: [LTP] [PATCH v3 1/2] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20201110114907.GB10788@pevik>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201110114907.GB10788@pevik>
Message-ID: <2864fc7e-5d23-8c07-357e-6161121dc4be@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10. 11. 20 12:49, Petr Vorel wrote:
>> Also check for SecureBoot status in tst_lockdown_enabled() if the lockdown
>> sysfile is not available/readable
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

Ah, yes, I guess that part of commit message should be dropped. Sorry
about that.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

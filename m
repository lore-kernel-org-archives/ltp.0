From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 11 Sep 2020 17:37:23 +0200
Subject: [LTP] [PATCH] syscalls/ptrace10: Add new regression test
In-Reply-To: <20200911153659.GA7234@yuki.lan>
References: <20200904180030.14838-1-chrubis@suse.cz>
 <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
 <20200911153659.GA7234@yuki.lan>
Message-ID: <eeeae258-d19b-eaaa-850e-6c6260b2447d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11. 09. 20 17:36, Cyril Hrubis wrote:
> I would like to avoid triggering the "your system may be vunerable"
> messages on fixed kernel, hence the separate test.

Good point, go ahead with a separate test then.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

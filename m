From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2020 12:55:38 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <20201110115146.GC10788@pevik>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201109164605.25965-2-mdoucha@suse.cz>
 <20201110115146.GC10788@pevik>
Message-ID: <20201110115538.GB13013@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I wonder if this could be interesting for docparse to have this functionality
> exposed as a struct tst_test flag:
> .tst_lockdown_restricted = 1

Well if we happen to have more than two testcases in the future it would
make sense to move the checks to the library like this instead.

-- 
Cyril Hrubis
chrubis@suse.cz

From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 5 Feb 2020 16:25:48 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <20200205143107.GC30186@rei>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz> <20200205143107.GC30186@rei>
Message-ID: <fda46288-1850-8ac9-1c56-7641aaeb8759@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/5/20 3:31 PM, Cyril Hrubis wrote:
>> diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
> 
> Why can't we keep the code in the header? I do not condsider this to be
> improving anything at all.

Because executable code doesn't belong in header files unless necessary.
Header files are as much API documentation for developers as they are
code for compilers. And header files full of executable code make
terrible API documentation.

I'll implement the rest of your suggestions and resubmit.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

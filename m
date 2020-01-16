From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Jan 2020 16:37:42 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.13-rc1-7f1b863.cki
 (stable)
In-Reply-To: <84944fa0-3c18-f8a4-47ca-7627eb4e0594@redhat.com>
References: <cki.FA900DB853.LBD049H627@redhat.com>
 <84944fa0-3c18-f8a4-47ca-7627eb4e0594@redhat.com>
Message-ID: <20200116153741.GA558@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > One or more kernel tests failed:
> > 
> >      ppc64le:
> >       ??? LTP
> 
> Hi, I see max_map_count failed on ppc64le:
> https://artifacts.cki-project.org/pipelines/385189/logs/ppc64le_host_2_LTP_mm.run.log

That's strange, we do attempt to map 65536 mappings but we do not touch
them, so these shouldn't be faulted in, so there is no real reason why
mmap() in the child process should stop prematurely at 65532.

I guess that we cannot do much here, unless it's reproducible, because
there is not much information there.

-- 
Cyril Hrubis
chrubis@suse.cz

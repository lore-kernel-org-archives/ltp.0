From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 17 Jan 2020 03:35:11 -0500 (EST)
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.13-rc1-7f1b863.cki
 (stable)
In-Reply-To: <20200116153741.GA558@rei>
References: <cki.FA900DB853.LBD049H627@redhat.com>
 <84944fa0-3c18-f8a4-47ca-7627eb4e0594@redhat.com> <20200116153741.GA558@rei>
Message-ID: <1477632721.2420697.1579250111441.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > One or more kernel tests failed:
> > > 
> > >      ppc64le:
> > >       ??? LTP
> > 
> > Hi, I see max_map_count failed on ppc64le:
> > https://artifacts.cki-project.org/pipelines/385189/logs/ppc64le_host_2_LTP_mm.run.log
> 
> That's strange, we do attempt to map 65536 mappings but we do not touch
> them, so these shouldn't be faulted in, so there is no real reason why
> mmap() in the child process should stop prematurely at 65532.
> 
> I guess that we cannot do much here, unless it's reproducible, because
> there is not much information there.

max_map_count.c:205: FAIL: 64882 map entries in total, but expected 65536 entries

I can reproduce it by running it in loop for couple hours. Though no idea
why we started seeing it only in 5.4.13 rc kernels, as there doesn't seem
to be any significant mm changes.

I'll try some older kernels.


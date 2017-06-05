From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 5 Jun 2017 10:28:55 -0700
Subject: [LTP] kernel of next-20170602 call trace when run add_key02 in
	LTP
In-Reply-To: <20170605134823.GA24454@rei.lan>
References: <CACsHhCKXwfo3hn3uNwQUWTg-MS9Ja5_5USO--Df3kRi2Z0b-hg@mail.gmail.com>
 <20170605134823.GA24454@rei.lan>
Message-ID: <20170605172855.GA87699@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Jun 05, 2017 at 03:48:23PM +0200, Cyril Hrubis wrote:
> Hi,
> > Compile kernel (next-20170602) and run ltp, find:
> > 
> > / # ./add_key02
> > tst_test.c:878: INFO: Timeout per run is 0h 05m 00s
> > [  341.183219] BUG: unable to handle kernel NULL pointer dereference at   (null)
> > [  341.183850] IP: memset+0x10/0x20
> > [  341.184550] *pdpt = 0000000035441001 *pde = 0000000000000000
> > [  341.184550]
> > [  341.184550] Oops: 0002 [#2] SMP
> > [  341.184550] Modules linked in:
> > [  341.184550] CPU: 0 PID: 124 Comm: add_key02 Tainted: G S    D W
> >   4.12.0-rc3-next-20170602 #3
> > [  341.184550] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS Bochs 01/01/2011
> > [  341.184550] task: f5b9ca00 task.stack: f6514000
> > [  341.184550] EIP: memset+0x10/0x20
> > [  341.184550] EFLAGS: 00000246 CPU: 0
> > [  341.184550] EAX: 00000000 EBX: 00000000 ECX: 00000001 EDX: 00000000
> > [  341.184550] ESI: 00000000 EDI: 00000000 EBP: f6515f24 ESP: f6515f1c
> > [  341.184550]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> > [  341.184550] CR0: 80050033 CR2: 00000000 CR3: 36404920 CR4: 000006f0
> > [  341.184550] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [  341.184550] DR6: 00000000 DR7: 00000000
> > [  341.184550] Call Trace:
> > [  341.184550]  memzero_explicit+0xf/0x20
> > [  341.184550]  SyS_add_key+0x11f/0x1c0
> > [  341.184550]  ? change_pid+0x13/0x50
> > [  341.184550]  do_fast_syscall_32+0x8b/0x130
> > [  341.184550]  entry_SYSENTER_32+0x4e/0x7c
> > [  341.184550] EIP: 0xb772ddc1
> > [  341.184550] EFLAGS: 00000246 CPU: 0
> > [  341.184550] EAX: ffffffda EBX: 080de341 ECX: 080de346 EDX: 00000000
> > [  341.184550] ESI: 00000001 EDI: fffffffc EBP: 0808aa97 ESP: bfe3636c
> > [  341.184550]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
> > [  341.184550] Code: 8a 0e 88 0f 8d b4 26 00 00 00 00 8b 45 f0 83 c4
> > 04 5b 5e 5f 5d c3 90 8d 74 26 00 3e 8d 74 26 00 55 89 e5 57 89 c7 53
> > 89 c3 89 d0 <f3> aa 89 d8 5b 5f 5d c3 90 90 90 90 90 90 90 90 3e 8d 74
> > 26 00
> > [  341.184550] EIP: memset+0x10/0x20 SS:ESP: 0068:f6515f1c
> > [  341.184550] CR2: 0000000000000000
> > [  341.219144] ---[ end trace e3963c970d107f91 ]---
> > tst_test.c:928: INFO: If you are running on slow machine, try
> > exporting LTP_TIMEOUT_MUL > 1
> > tst_test.c:929: BROK: Test killed! (timeout?)
> > 
> > I try to use other tags and kernel on next-20170427 is ok, but
> > next-20170502 fail.
> > Is it bug?
> 
> Looks like a kernel bug to me.
> 
> The test is a very simple one that just does:
> 
> add_key("keyring", "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));
> 
> And expects success.

Actually: add_key("user", "firstkey", NULL, 1, KEY_SPEC_USER_KEYRING) and
expects EINVAL.  Coincidentally I'm just about to send an update for this test
to make it test the fix for the real bug, which will make this call fail with
EFAULT instead, but yes crashing is completely broken of course, and it's broken
in linux-next because it's broken in keys-next.  It's fixed in the "keys-fixes"
branch.  David, can you get keys-next up to date with keys-fixes so that people
don't run into this bug?  Note that it was also hit with the Trinity fuzzer.

Eric

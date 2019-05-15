From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 14 May 2019 23:01:19 -0400
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <20190514121213.GA28655@dell5510>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
Message-ID: <1557889279.4581.14.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Tue, 2019-05-14 at 14:12 +0200, Petr Vorel wrote:
> Hi Mimi, Ignaz,
>=20
> Mimi, could you please have a second look on this [4] patchset? We've had=
 a
> discussion about second patch [5], I can drop it if you don't like it, but
> that's not a main concern about this test. More important is whether the
> testcase looks valid for you. It's about overlayfs broken in IMA+EVM,
> which is currently broken on mainline.

The first two patches are fine. =C2=A0From the test, I'm seeing the
following results:

evm_overlay 1 TINFO: overwrite file in overlay
tst_rod: Failed to open '(null)' for writing: Operation not permitted
evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpec=
tedly
evm_overlay 2 TINFO: append file in overlay: mntpoint/lower/foo2.txt
evm_overlay 2 TPASS: echo overlay >> mntpoint/merged/foo2.txt passed as exp=
ected
evm_overlay 3 TINFO: create a new file in overlay
evm_overlay 3 TPASS: echo overlay > mntpoint/merged/foo3.txt passed as expe=
cted
evm_overlay 4 TINFO: read all created files
evm_overlay 4 TFAIL: cat mntpoint/merged/foo1.txt > /dev/null 2> /dev/null =
failed unexpectedly
evm_overlay 4 TFAIL: cat mntpoint/merged/foo2.txt > /dev/null 2> /dev/null =
failed unexpectedly
evm_overlay 4 TFAIL: cat mntpoint/merged/foo3.txt > /dev/null 2> /dev/null =
failed unexpectedly
evm_overlay 5 TINFO: SELinux enabled in enforcing mode, this may affect tes=
t results
evm_overlay 5 TINFO: You can try to disable it with TST_DISABLE_SELINUX=3D1=
 (requires super/root)
evm_overlay 5 TINFO: loaded SELinux profiles: none

With "evm: instead of using the overlayfs i_ino, use the real i_ino"
patch, I'm only seeing the first failure.

Mimi


> There is different reproducer (C code) for a slightly different scenario,
> but I'm not going to port it before this got merged.
>=20
> Ignaz, could you please test this patchset? Could you, please, share your=
 setup?
> ima_policy=3Dappraise_tcb kernel parameter and loading IMA and EVM keys o=
ver
> dracut-ima scripts? (IMA appraisal and EVM using digital signatures? I gu=
ess
> using hashes for IMA appraisal would work as well).
>=20
> Kind regards,
> Petr
>=20
> > this is a second version of patch demonstrating a bug on overlayfs when
> > combining IMA with EVM. There is ongoing work made by Ignaz Forster and
> > Fabian Vogt [1] [2], IMA only behavior was already fixed [3].
>=20
> > Main patch is the last one (previous are just a cleanup and not changed=
).
>=20
> > [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> > [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> > [3] https://patchwork.kernel.org/patch/10776231/
>=20
> [4] https://patchwork.ozlabs.org/project/ltp/list/?series=3D101213&state=
=3D*
> [5] https://patchwork.ozlabs.org/patch/1078553/
>=20


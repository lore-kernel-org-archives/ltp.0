From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Apr 2018 17:09:13 +0200
Subject: [LTP] [RFC PATCH v3 01/10] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <1524838395.3416.65.camel@linux.vnet.ibm.com>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-2-pvorel@suse.cz>
 <1524838395.3416.65.camel@linux.vnet.ibm.com>
Message-ID: <20180428150913.6gf6kkpdf5r7kcm6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Mimi,

> > +ima_check()
...
> > +	[ "$DIGEST_INDEX" ] && digest=3D"$(echo "$line" | awk '{print $(NF-'$=
DIGEST_INDEX')}' | cut -d ':' -f 1)"
> > +	hash=3D"$(echo "$line" | awk '{print $(NF-1)}' | cut -d ':' -f 2)"

> With the "ima-sig" template, with a measurement that does not contain
> the signature, this works fine. =C2=A0There's a problem with lines
> containing the signature.

> Sample ima-sig template measurements with/without the signature:
> line=3D"10 ee788468d1b416a394feb9f4e5650302d9cd5574 ima-sig sha256:866c25=
42efd5c7528591eb3bb2861a1994a655da47732ccf28f7f4b1ce42d564 /usr/lib64/libpa=
m.so.0.84.1"

> line=3D"10 d3afb4df5fe42485b99677f4b68a04692977b4bc ima-sig sha256:7b8550=
8c9181670fe169935310b8c95d7c2573f0318a70cecd12868569aab891 /etc/profile.d/l=
ess.sh 0302046e6c104601008bd533707b34a9e896d3d530a88e9af517fb7e8cf79e9e5506=
4a577fcbcdb81236ede6fec0638d357e4c2ed9b261320f8789378d1e58af8e1c6f40ebdf080=
759be2c633b27bc8aed85af0620fa27700c68fdf31d33b2f9e36432a1e7d7eb8dbf20b9474d=
332deb9697767ee13e13c116544a843b54fce842d24ea485bb41f6f7b1e9fa3faed0c591f52=
43cee008b9499e48064141662d3c4d002b07448ae54dc8d8674437143d73c4e34f5b416300b=
a890dc391eae9e5b1e89190790d0ea77d1dc57e07dae9ca003294a36fda09c31f8afa347701=
bfcf5aed0fda9cf7a37f734ba80fc10f2d60409f0beba532f3e5cc15ae995128e466b20fdad=
ef789e285519"

Sorry, I haven't setup machine with IMA signature support yet. So booting w=
ith
ima_template_fmt=3Dd-ng|n-ng|sig (or kernel with CONFIG_IMA_DEFAULT_TEMPLAT=
E=3D"ima-sig")
without any keys generated with evmctl obviously doesn't bring any signatur=
es.

It could be a solution to detect presence of signature for 'ima-sig' with s=
imple counting
parameters (5: no signature, 6: signature when ima_template_fmt is not used=
).  And good
thing is that line without signature is different: signature part isn't lef=
t, but there is
and space (' ') for it.

The detection of both indexes (the hash itself and the digest) needs to be =
bit smarter
anyway as imagine someone crazy using ima_template_fmt=3Dd-ng|n-ng|sig|d-ng=
|n-ng|sig
parameter.

Kind regards,
Petr

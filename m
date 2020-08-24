From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Aug 2020 13:08:13 +0200
Subject: [LTP] [PATCH 1/1] prepare_lvm.sh: Allow to define tmp directory
In-Reply-To: <332d88d9-7a5e-c45a-273e-61da8aaad3c6@suse.cz>
References: <20200824102439.26587-1-pvorel@suse.cz>
 <332d88d9-7a5e-c45a-273e-61da8aaad3c6@suse.cz>
Message-ID: <20200824110813.GA13255@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

...
> You should change only LVM_IMGDIR where the backing files are stored. If
> you also change LVM_TMPDIR, it'll break the lvm.local runfile.
Wouldn't be less confusing to change both directories? Updating
generate_lvm_runfile.sh is trivial (ignoring variable setup in all 3 scripts):

- sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
+ sed -e "s/{fsname}/$fsname/g; s^/tmp/ltp/^$LVM_DIR/ltp^g" "$INFILE" >>"$OUTFILE"

> Also don't forget to update cleanup_lvm.sh.
Good point, thanks!

Kind regards,
Petr

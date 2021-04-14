From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Apr 2021 20:34:25 +0200
Subject: [LTP] [PATCH v2 1/1] travis: Fix openSUSE Tumbleweed
In-Reply-To: <20210414182850.23308-1-pvorel@suse.cz>
References: <20210414182850.23308-1-pvorel@suse.cz>
Message-ID: <YHc1sffWE/P2+dFw@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

still some errors for podman[1]:

$ sudo $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
WARN[0001] Error validating CNI config file /etc/cni/net.d/87-podman-bridge.conflist: [
failed to find plugin "bridge" in path [/usr/libexec/cni /usr/lib/cni /usr/local/lib/cni /opt/cni/bin]
failed to find plugin "portmap" in path [/usr/libexec/cni /usr/lib/cni /usr/local/lib/cni /opt/cni/bin]
failed to find plugin "firewall" in path [/usr/libexec/cni /usr/lib/cni /usr/local/lib/cni /opt/cni/bin]
failed to find plugin "tuning" in path [/usr/libexec/cni /usr/lib/cni /usr/local/lib/cni /opt/cni/bin]]

? Please select an image:
? docker.io/library/ima-evm-utils:latest
  quay.io/ima-evm-utils:latest

Sorry for overlooking it.

Kind regards,
Petr

[1] https://travis-ci.org/github/pevik/ima-evm-utils/jobs/762170220#L491

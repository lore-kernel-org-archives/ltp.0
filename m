From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 16:36:55 +0100
Subject: [LTP] [PATCH 2/2] syscalls/open_tree: Set .mount_device to get
 rid of mounting related code
In-Reply-To: <c1cee81b06a1195635eca1791e0af9c22798e9f7.1584947466.git.viresh.kumar@linaro.org>
References: <aa66c041b2eca3f874056de72ca3dcdf8825a6b5.1584947466.git.viresh.kumar@linaro.org>
 <c1cee81b06a1195635eca1791e0af9c22798e9f7.1584947466.git.viresh.kumar@linaro.org>
Message-ID: <20200323153655.GA15673@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> We don't necessarily need to work with the fsmount() related syscalls to
> initially mount the device, we can set .mount_device instead and get rid
> of a lot of code.

Patchset merged. Thanks!

Kind regards,
Petr

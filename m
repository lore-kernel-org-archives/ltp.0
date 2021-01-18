From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Jan 2021 17:55:56 +0800
Subject: [LTP] [PATCH 1/1] travis: Temporary workaround for pull rate
 limit
In-Reply-To: <20210118081350.21418-1-pvorel@suse.cz>
References: <20210118081350.21418-1-pvorel@suse.cz>
Message-ID: <60055B2C.1080607@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
I think using gcr.io mirror as a temporary solution is OK. But why we
not migrate into Github Actions directly? Now, it is time to this
release and do we should apply it before release?

Best Regards
Yang Xu
> Use mirror.gcr.io mirror to temporary workaround pull rate limit in
> docker registry. Correct solution is to migrate to Github Actions.
> 
> See also: #761
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
> Hi,
> 
> not a final solution for #761, just to get Travis quickly working.
> 
> Kind regards,
> Petr
> 
>   .travis.yml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index edf627c33..245b790de 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -85,6 +85,14 @@ matrix:
> 
>   before_install:
>       - df -hT
> +    # pull rate limit workaround
> +    - tmpdaemon=$(mktemp)
> +    - sudo jq '."registry-mirrors" += ["https://mirror.gcr.io"]' /etc/docker/daemon.json>  $tmpdaemon
> +    - sudo mv $tmpdaemon /etc/docker/daemon.json
> +    - sudo systemctl daemon-reload
> +    - sudo systemctl restart docker
> +    - docker system info
> +    # ltp
>       - DIR="/usr/src/ltp"
>       - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n">  Dockerfile
>       - cat Dockerfile




var Ideas;

Ideas = {}

Ideas.removeIdeaCard = function(ideaId) {
  document.getElementById("idea-" + ideaId).parentElement.remove();
};
